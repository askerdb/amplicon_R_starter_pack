source("import_conversion_common.R")

#If the data was not denovo clustered load the full gg_13 tree. This is pretty big.
#TODO: find some automatic way of validating that OTUs were actually picked against gg13
if (file.exists("rep_set_midpoint.tre")){
  all_samples load_phyloseq("mapping.txt", "otu_table.biom", "rep_set.tre")
}
else{
  #Tree taken from https://groups.google.com/forum/#!msg/qiime-forum/v-TfjP20uws/uvvySwyHPAsJ
  all_samples <- load_phyloseq("mapping.txt", "otu_table.biom", "gg_13_5_unannotated.tree")
}

all_samples_mgs <- make_metagenomeSeq(all_samples)

save(all_samples, all_samples_mgs file="phyloseq_metagenomeSeq.RData")