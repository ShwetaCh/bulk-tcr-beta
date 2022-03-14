#!/bin/bash

$QCFOLDER="outputsQC"
SAMPLESHEET1="../inputs/samplesheet_EXP21001376.tsv"

##Edit block above to point to appropriate paths
#---------------------------------------------------------------------------

mkdir -p $QCFOLDER
while read -r SAMPLE FASTQ1 FASTQ2 REST; do
    echo "Working on --> "$SAMPLE
    fastp -h outputsQC/${SAMPLE}_fastp.html -j outputsQC/${SAMPLE}_fastp.json -i ${FASTQ1} -I ${FASTQ2} -o ${FASTQ1}.trimmed.fastq.gz -O ${FASTQ2}.trimmed.fastq.gz \
    -y -3 --cut_tail_window_size 4 -5 --cut_front_window_size 4 -l 40 -n 5 -p
    fastqc ${FASTQ1} ${FASTQ2}
done < $SAMPLESHEET1

multiqc $QCFOLDER
