task kallisto_test {
    Int bootstrap_count
    File R1
    File R2
    Int size_disk

    File index_transcriptome
    Int n_threads
    String n_GB_RAM

    command <<<
        kallisto quant \
            -i ${index_transcriptome} \
            --threads ${n_threads} \
            --output-dir . \
            --bootstrap-samples=${bootstrap_count} \
            ${R1} ${R2}
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
        disks: "local-disk ${size_disk} HDD"
    }
}

workflow kallisto_quant {
    Int bootstrap_count
    File R1
    File R2
    File index_transcriptome

    call kallisto_test {
        input:
            bootstrap_count=bootstrap_count,
            R1=R1,
			R2=R2,
            index_transcriptome=index_transcriptome
    }
}