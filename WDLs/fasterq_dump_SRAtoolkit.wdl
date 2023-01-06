task fasterqdump {
	String SRRaccession
    Int n_threads
    String n_GB_RAM
    Int size_disk

    command <<<
		export PATH=$PATH:/SRA/sratoolkit.3.0.1-ubuntu64/bin 
		fasterq-dump ${SRRaccession}
    >>>

    output {
        File fastq1 = "${SRRaccession}_1.fastq"
		File fastq2 = "${SRRaccession}_2.fastq"
    }

	runtime {
    	docker: "hbbouwman/terra_kallisto:v3"
        cpu: n_threads
        memory: n_GB_RAM
        disks: "local-disk ${size_disk} SSD"
    }
}

workflow SRA_fasterq_dump {
	String SRRaccession
    call fasterqdump {
	input: SRRaccession=SRRaccession}
}