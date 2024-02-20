library(Seurat)
library(velocyto.R)
library(SeuratWrappers)

CD4 <- as.Seurat(ReadVelocity("CD4_sample_demux_5O2KH.loom"))
CD8 <- as.Seurat(ReadVelocity("CD8_sample_demux_CR3PW.loom"))
mait <- as.Seurat(ReadVelocity("MAIT_sample_demux_02PC4.loom"))
nkt <- as.Seurat(ReadVelocity("NKT_sample_demux_GE4LM.loom"))

 
CD4[['RNA']] <- CreateAssayObject(counts = CD4@assays$spliced@counts + CD4@assays$unspliced@counts + CD4@assays$ambiguous@counts)
CD8[['RNA']] <- CreateAssayObject(counts = CD8@assays$spliced@counts + CD8@assays$unspliced@counts + CD8@assays$ambiguous@counts)
mait[['RNA']] <- CreateAssayObject(counts = mait@assays$spliced@counts + mait@assays$unspliced@counts + mait@assays$ambiguous@counts)
nkt[['RNA']] <- CreateAssayObject(counts = nkt@assays$spliced@counts + nkt@assays$unspliced@counts + nkt@assays$ambiguous@counts)

mergedObj <- merge(CD4, y = c(CD8, mait, nkt), add.cell.id = c("cd4", "cd8", "mait", "nkt"))