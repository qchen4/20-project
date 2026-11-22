# BPPE 决策记录

用于记录影响算法、接口、数值或微架构的选择。已有 [ADR-001 M0 实验基线](ADR-001-m0-baseline.md)，仅在用户授权的实验实现范围内生效，未构成系统架构签核。

定点实现方式与默认位宽选择见 [ADR-002](ADR-002-integer-fixed-baseline.md)。

负责人确认先推进 FPGA 工程原型，见 [ADR-003](ADR-003-fpga-engineering-prototype.md)。

从 [模板](template.md) 创建 `ADR-NNN-主题.md` 等文件。状态为 Proposed、Accepted、Rejected 或 Superseded；实验授权可标记 Accepted for experiment，并明确授权依据和范围。正式 Accepted 必须记录实际批准人、日期和适用规格版本。

记录描述选择与理由，最终行为同步到所属规格。既有决策改变时保留原记录并指向替代记录，避免丢失设计依据。


- [ADR-004: Pending prototype results](ADR-004-prototype-pending-result.md): owner-confirmed continued computation with first-snapshot retention; bus, IRQ and same-cycle priorities remain open.


- [ADR-005: Integer tick deadlines](ADR-005-integer-window-deadlines.md): owner-approved timeout boundary correction and audited host conversion rules.

- [ADR-006: 30 MHz prototype clock](ADR-006-30mhz-prototype-clock.md): owner-confirmed core target; current OOC defaults are 33.333ns, with implementation and board constraints still pending.
