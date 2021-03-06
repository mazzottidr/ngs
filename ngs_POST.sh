#!/bin/bash

# Copyright (c) 2012,2013, Stephen Fisher and Junhyong Kim, University of
# Pennsylvania.  All Rights Reserved.
#
# You may not use this file except in compliance with the Kim Lab License
# located at
#
#     http://kim.bio.upenn.edu/software/LICENSE
#
# Unless required by applicable law or agreed to in writing, this
# software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License
# for the specific language governing permissions and limitations
# under the License.

##########################################################################################
# SINGLE-END READS
# INPUT: $SAMPLE/trim/unaligned_1.fq
# OUTPUT: $SAMPLE/trim/unaligned_1.fq.gz
#
# PAIRED-END READS
# INPUT: $SAMPLE/trim/unaligned_1.fq and $SAMPLE/trim/unaligned_2.fq
# OUTPUT: $SAMPLE/trim/unaligned_1.fq.gz and $SAMPLE/trim/unaligned_2.fq.gz
##########################################################################################

##########################################################################################
# USAGE
##########################################################################################

ngsUsage_POST="Usage: `basename $0` post OPTIONS sampleID    --  clean up RUM and trimmed data\n"

##########################################################################################
# HELP TEXT
##########################################################################################

ngsHelp_POST="Usage:\n\t`basename $0` post [-i inputDir] sampleID\n"
ngsHelp_POST+="Input:\n\tsampleID/INPUTDIR/unaligned_1.fq\n\tsampleID/INPUTDIR/unaligned_2.fq (paired-end reads)\n"
ngsHelp_POST+="Output:\n\tsampleID/INPUTDIR/unaligned_1.fq.gz\n\tsampleID/INPUTDIR/unaligned_2.fq.gz (paired-end reads)\n"
ngsHelp_POST+="Compresses trim files."

##########################################################################################
# PROCESSING COMMAND LINE ARGUMENTS
# POST args: sampleID
##########################################################################################

ngsArgs_POST() {
	if [ $# -lt 1 ]; then
		printHelp $COMMAND
		exit 0
	fi

    # default value
	INPDIR="trim"

	# getopts doesn't allow for optional arguments so handle them manually
	while true; do
		case $1 in
			-i) INPDIR=$2
				shift; shift;
				;;
			-*) printf "Illegal option: '%s'\n" "$1"
				printHelp $COMMAND
				exit 0
				;;
 			*) break ;;
		esac
	done

	SAMPLE=$1
}

##########################################################################################
# RUNNING COMMAND ACTION
# POST command. Compresses trimming data.
##########################################################################################

ngsCmd_POST() {
	prnCmd "# BEGIN: POST PROCESSING"
	
	prnCmd "gzip $SAMPLE/$INPDIR/*fq"
	if ! $DEBUG; then 
		gzip $SAMPLE/$INPDIR/*fq
	fi
	
	prnCmd "# FINISHED: POST PROCESSING"
}
