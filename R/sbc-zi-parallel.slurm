#!/bin/bash
#SBATCH -J microbe_models_pH3.R # Name for your job
#SBATCH -n 1 # Number of tasks when using MPI. Default is 1
#SBATCH -c 19 # Number of cores requested, Default is 1 (total cores requested = tasks x cores)
#SBATCH -N 1 # Number of nodes to spread cores across - default is 1 - if you are not using MPI this should likely be 1
#SBATCH --mem 120000 #the minimum amount of memory per core to request, Default is 10 MB so be sure to include this (Max for community.q, kill.q, sb.q and exclusive.q are 6400)
#SBATCH -t 4000 # Runtime in minutes. Default is 10 minutes. The Maximum runtime currently is 72 hours, 4320 minutes - requests over that time will not run
#SBATCH -p ikewai # Partition to submit to the standard compute node partition(community.q) or the large memory node partition(lm.q)
#SBATCH -A ikewai # Account to use
#SBATCH -o microbe_model_pH4.out # Standard out goes to this file
#SBATCH -e microbe_model_pH4.err # Standard err goes to this file
#SBATCH --mail-user klfrank@hawaii.edu # this is the email you wish to be notified at
#SBATCH --mail-type ALL # this specifies what events you should get an email about ALL will alert you of job beginning, completion, failure etc


source ~/.bash_profile #if you want to use modules or need environment variables use this if your shell is bash to load those
module load lang/Anaconda3 #load anaconda 
source activate renv # load conda virtual environment with R and dependencies installed
# module load lang/R/4.0.0-intel-2018.5.274-Python-2.7.15 #if you want to load a module use this and the above common with the module name you wanted loaded.
R < mm_zi_pH-parallel.R --no-save # or myscript-or-command put the commands you want to run
