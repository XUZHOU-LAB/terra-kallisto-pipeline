task kallisto_test {
    Int bootstrap_count
    File L001_R1
    File L001_R2
    File L002_R1
    File L002_R2
    File L003_R1
    File L003_R2
    File L004_R1
    File L004_R2
    File index_transcriptome
    Int n_threads
    String n_GB_RAM

    command <<<
        kallisto quant \
            -i ${index_transcriptome} \
            --threads ${n_threads} \
            --output-dir . \
            --bootstrap-samples=${bootstrap_count} \
            ${L001_R1} ${L001_R2} ${L002_R1} ${L002_R2} ${L003_R1} ${L003_R2} ${L004_R1} ${L004_R2}
    >>>

    output {
        File abundance = "abundance.tsv"
        File bootstraps = "abundance.h5"
        File run_info = "run_info.json"
    }

	runtime {
    	docker: "hbbouwman/terra_kallisto:v2"
        cpu: n_threads
        memory: n_GB_RAM 
    }
}

workflow kallisto_quant {
    Int bootstrap_count
    File L001_R1
    File L001_R2
    File L002_R1
    File L002_R2
    File L003_R1
    File L003_R2
    File L004_R1
    File L004_R2
    File index_transcriptome

    call kallisto_test {
        input:
            bootstrap_count=bootstrap_count,
            L001_R1=L001_R1,
			L001_R2=L001_R2,
			L002_R1=L002_R1,
			L002_R2=L002_R2,
            L003_R1=L003_R1,
			L003_R2=L003_R2,
			L004_R1=L004_R1,
			L004_R2=L004_R2,
            index_transcriptome=index_transcriptome
    }
}