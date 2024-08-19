#!/bin/bash
DIRPARAMS=$1
echo $DIRPARAMS
GPU_ID=0 # the GPU to be used
seq_flag=0 # sequnetial learning flag (no-sequential)
sigma=0.0 # noise
nl=1 # number of dendro-somatic layers (2 hidden layers)
nsyn=16 # number of synapses
drop_flag=0 # dropout flag for vanilla model
rate=0 # rate of dropout
lr=0.001 # adam learning rate
es_flag=1 # early stop flag
# if the fig2 script has run, no need for fmnist afain. If not, add it the for loop for data
for d in 1 2 4 8 16 32 64; do
  for s in 32 64 128 256 512; do
    for data in fmnist cifar10; do #mnist fmnist kmnist emnist cifar10; do
      for t in $(seq 1 5); do
        for m in $(seq 0 11); do
          echo "Trial:" $t "Model:" $m "dends:" $d "soma:" $s
          python main.py $GPU_ID $seq_flag $t $m $sigma $data $d $s $nl $nsyn $drop_flag $rate $lr $es_flag $DIRPARAMS
        done
      done
    done
  done
done
