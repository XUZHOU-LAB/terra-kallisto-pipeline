task kallisto_build_index {
    File index_transcriptome
    Int n_threads
    String n_GB_RAM

    command <<<
    	kallisto index -i transcripts.idx ${index_transcriptome}
    >>>

    output {
        File kallisto_index_file = "transcripts.idx"
    }

	runtime {
    	docker: "hbbouwman/terra_kallisto:v2"
        cpu: n_threads
        memory: n_GB_RAM 
    }
}

workflow kallisto_quant {
    File index_transcriptome

    call kallisto_build_index {
        input:
            index_transcriptome=index_transcriptome
    }
}