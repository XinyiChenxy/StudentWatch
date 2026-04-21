# shell_run Organization / shell_run 目录说明

## English

This directory keeps all original experiment scripts at the top level and adds new category subfolders only for organization.
No original scripts are deleted, renamed, or moved. The new subfolders contain lightweight wrapper scripts and `run_all.sh` entrypoints.

### Organization logic

- `01_baseline_reference/`
  - Reference starting point experiments.
  - Used to record the original baseline before later changes.
- `02_data_imbalance_handling/`
  - Non-SE experiments that address class imbalance.
  - Covers dropping the rare class, augmentation, weighted loss, and their combination.
- `03_se_imbalance_handling/`
  - SE-based versions of the imbalance-handling stage.
  - Used to compare whether SE improves the no-hr / aug / weighted strategies.
- `04_se_ablation/`
  - Later SE placement ablations.
  - Used to compare where SE is inserted in the backbone or head.

### How to run one category

Example:

```bash
bash shell_run/02_data_imbalance_handling/run_all.sh
```

You can also run any wrapper script inside a category folder directly, or keep using the original top-level scripts.

### How to run all categories

```bash
bash shell_run/run_all_by_category.sh
```

### Important note

The original scripts in `shell_run/` are preserved for backward compatibility.
The new category folders are added only to improve readability, experiment management, and teammate onboarding.

## 中文

该目录保留了所有原始实验脚本在顶层位置，同时新增了按实验逻辑分类的子文件夹，仅用于整理和管理。
没有删除、重命名或移动任何原始脚本。新增的子文件夹中包含轻量包装脚本以及对应的 `run_all.sh` 入口脚本。

### 分类逻辑

- `01_baseline_reference/`
  - 基线参考实验。
  - 用于记录后续改动之前的原始对照结果。
- `02_data_imbalance_handling/`
  - 不使用 SE 的类别不平衡处理实验。
  - 包含删去稀有类别、数据增强、加权损失及其组合。
- `03_se_imbalance_handling/`
  - 使用 SE 的类别不平衡处理实验。
  - 用于比较在 no-hr / aug / weighted 方案中加入 SE 是否有帮助。
- `04_se_ablation/`
  - 后续 SE 插入位置消融实验。
  - 用于比较 SE 放在 backbone 或 head 不同位置时的效果。

### 如何运行某一类实验

示例：

```bash
bash shell_run/02_data_imbalance_handling/run_all.sh
```

你也可以直接运行某个分类目录中的包装脚本，或者继续使用原来位于顶层的脚本。

### 如何运行全部分类实验

```bash
bash shell_run/run_all_by_category.sh
```

### 重要说明

`shell_run/` 顶层中的原始脚本全部保留，以保证兼容旧流程。
新增的分类目录仅用于提升可读性、实验管理清晰度以及团队协作时的理解效率。
