args = commandArgs(trailingOnly=TRUE)

secretome_table = read.table(args[1], sep='\t', header=T)

# candidate effectors called by effctorP
secretome_table$CEP_by_effectorP = ifelse(secretome_table$EffectorP_res == "Effector", "yes", "no")

# candidate effectors based on protein composition
secretome_table$CEP_by_prot_comp = ifelse(secretome_table$length <= 250 & secretome_table$cysteines_perc >= 2 & secretome_table$predGPI_FPrate > 0.005 & secretome_table$TMH_num ==  secretome_table$TMH_begin_num, "yes", "no")

# candidate effectors based on lack of homology
secretome_table$CEP_by_lack_homology = ifelse(secretome_table$predGPI_FPrate > 0.005 & secretome_table$TMH_num ==  secretome_table$TMH_begin_num & secretome_table$num_blast_hits == 0, "yes", "no")


write.table(secretome_table, args[2], sep = '\t', row.names = F, quote = F)

