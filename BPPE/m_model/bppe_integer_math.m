classdef bppe_integer_math < handle
    % Integer codes stored in doubles ONLY while exact (abs <= 2^53-1).
    % No floating DSP arithmetic: full integer product, quotient/remainder,
    % explicit half-away rounding, integer sqrt and saturating destination.
    properties
        stats = struct()
        saturation_count = 0
        divzero_count = 0
        precision_fault_count = 0
    end
    methods
        function r=encode(q,x,w,f,signed,name)
            % Host-side constants/configuration conversion, not runtime DSP.
            raw=round(double(x)*2^f);
            r=q.clip(raw,w,signed,name);
        end
        function r=clip(q,raw,w,signed,name)
            assert(w>=1 && w<=52 && w==fix(w),'BPPE:Width','Unsupported width.');
            if signed, lo=-2^(w-1); hi=2^(w-1)-1;
            else, lo=0; hi=2^w-1; end
            bad=~isfinite(raw) | raw<lo | raw>hi;
            q.saturation_count=q.saturation_count+sum(bad(:));
            raw(isnan(raw))=0;
            r=min(max(raw,lo),hi);
            if ~isfield(q.stats,name)
                q.stats.(name)=struct('count',0,'min_raw',Inf,'max_raw',-Inf,'saturations',0);
            end
            s=q.stats.(name);
            s.count=s.count+numel(raw); s.min_raw=min(s.min_raw,min(raw(:)));
            s.max_raw=max(s.max_raw,max(raw(:))); s.saturations=s.saturations+sum(bad(:));
            q.stats.(name)=s;
        end
        function r=mul(q,a,b)
            limit=2^53-1;
            if any(abs(a(:))>limit./max(abs(b(:)),1)) || ...
                    any(~isfinite(a(:))) || any(~isfinite(b(:)))
                q.precision_fault_count=q.precision_fault_count+1;
                r=zeros(size(a))+zeros(size(b)); return
            end
            r=a.*b;
        end
        function r=add(q,a,b)
            limit=2^53-1;
            if any(abs(a(:))>limit-abs(b(:)))
                q.precision_fault_count=q.precision_fault_count+1;
                r=zeros(size(a))+zeros(size(b)); return
            end
            r=a+b;
        end
        function r=divide(q,n,d)
            % Scalar integer division; correction removes floating quotient
            % boundary rounding before exact remainder/tie handling.
            assert(isscalar(n)&&isscalar(d),'BPPE:Integer','Scalar division required.');
            if d==0
                q.divzero_count=q.divzero_count+1; r=0; return
            end
            if ~isfinite(n)||~isfinite(d)||abs(n)>2^53-1||abs(d)>2^53-1
                q.precision_fault_count=q.precision_fault_count+1; r=0; return
            end
            sign_result=sign(n)*sign(d); a=abs(n); b=abs(d);
            base=floor(a/b); rem=a-base*b;
            if rem<0, base=base-1; rem=rem+b; end
            if rem>=b, base=base+1; rem=rem-b; end
            if rem>=ceil(b/2), base=base+1; end
            r=sign_result*base;
        end
        function r=rescale(q,x,from_f,to_f)
            if to_f>=from_f
                r=q.mul(x,2^(to_f-from_f));
            else
                r=zeros(size(x));
                for k=1:numel(x), r(k)=q.divide(x(k),2^(from_f-to_f)); end
            end
        end
        function r=sqrt_nearest(q,n)
            % Integer binary search; no runtime floating sqrt approximation.
            if n<0 || n>2^53-1 || ~isfinite(n)
                q.precision_fault_count=q.precision_fault_count+1; r=0; return
            end
            lo=0; hi=min(n,94906265);
            while lo<hi
                mid=floor((lo+hi+1)/2);
                if mid*mid<=n, lo=mid; else, hi=mid-1; end
            end
            r=lo;
            % sqrt(n)>=lo+0.5 iff n-lo^2 >= lo+1 for integer n.
            if n-lo*lo>=lo+1, r=lo+1; end
        end
        function yes=failed(q)
            yes=q.saturation_count+q.divzero_count+q.precision_fault_count>0;
        end
    end
end
