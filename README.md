# Safety Analysis of Over-the-air Updates for CPS: An Approach for test case prioritizazion and Selection

This repository contains the necessary files to replicate the analysis exposed in the papaer *Safety Analysis of Over-the-air Updates for CPS: An Approach for test case prioritizazion and Selection*.

## Repository Structure

This repository contains 4 folders:

* `LaneFollowingControlWithSensorFusionAndLaneDetectionACC`: it contains the simulink model used to test the ACC controller
* `LaneFollowingControlWithSensorFusionAndLaneDetectionLKA`: it contains the simulink model used to test the LKA controller
* `Results/Statistical tests`: it contains the scripts to run the statistical tests and generate the results of RQ1
* `Results/Failure analisys`: it contains the scripts to run the failure analysis and generate the results of RQ2

## Requirements

To run the script and be able to open the Simulink models, ensure the following software is installed:

* MATLAB version R2024a or newer and the following Add-Ons:
    - Simulink
    - Simulink Test
    - Automated Driving Toolbox
    - Embedded Coder
    - Model Predictive Control Toolbox
    - Simulink 3D Animation
    - Image Processing Toolbox

* HECATE (follow the intructions written in the [tool repo](https://github.com/Hecate-SBST/Hecate/tree/main))

## How to run

After having added to the active path the necessary folders, navigate into the `LaneFollowingControlWithSensorFusionAndLaneDetectionACC` folder in order to perform the ACC controller simulations.

To open the Simulink model, run the following command: 
```
open_system('LaneFollowingTestBenchExample');
```

Note that it is important to open the simulink model before running the next commands, otherwise they will not work.

To run all the simulations of the case study, run the following command: 
```
Run_All_Configurations;
```

To run only one simulation of the case study (select the vehicle name and the scenario name inside the script), run the following command: 
```
Run_One_Configuration;
```

All vehicles and scenario names can be found in the `helperLFSetUp.m` file script.


To run all the simulations of the automotive SPL case study, in the order proposed by CRISP, run the following command: 
```
Run_by_fitness;
```

> [!NOTE]
> The same commands are present within the 'LaneFollowingControlWithSensorFusionAndLaneDetectionLKA' folder for testing the LKA's behavior.

## Introduction of OTA update

Here is an example example of how to introduce an over-the-air update:

* open the file `helperLFSetUp.m` within the desired folder (ACC or LKA)
* change the parameter that you want to test within the command `assignin` (example line 20: `min_acceleration` --> `min_acceleration*0.1`)
* test the update using the command
```
Run_by_fitness;
```

## Experiment results

Here, we describe how the experiment results are organized and how to run the scripts to generate the results of the two research questions of our paper.

### Statistical Tests

The folder `Statistical tests` contains the results of the prioritization technique and of the comparison with *random* and *AP-Disc*. 

> [!NOTE]
> Before running all the test be sure to load the data of the simulation perfomed by running the command: `load_data_CRISP_approach;load_data_APDISC_approach; load_data_random_approach;`

To run the A12 statistical test run the command: 
```
TEST_A12;
```

To run the Kolmogorov-smirnov statistical test run the command:
```
KS_statistical_test;
```

To run the APFD test run the command: 
```
APFD_CRISP;
```

To generate the box plot results run the command: 
```
Box_plot;
```


### Failure analysis

The folder `Failure analysis` contains the results of the selection technique.

To analyze the results obtained, it is necessary to run the command: 
```
delta_variation_graph;
``` 

This command generates the graph with the total time saved and the percentage of failure revealing test cases identified.

## Contributors

The following authors contributed to the paper *Safety Analysis of Over-the-air updates for CPS: An Approach For Test Case Prioritization and Selection*:


* *Andrea Bombarda*, University of Bergamo, Bergamo, Italy
* *Luca Carminati*, University of Bergamo, Bergamo, Italy
* *Nunzio Marco Bisceglia*, Gran Sasso Science Institute, L'Aquila, Italy
* *Mehrnoosh Askarpour*, General Motors Canada and McMaster University, Hamilton, Canada
* *Sahar Kokaly*, General Motors Canada and McMaster University, Hamilton, Canada
* *Ramesh S*, General Motors, Warren, Michigan, USA
* *Marsha Chechik*, University of Toronto, Toronto, Canada
* *Claudio Menghi*, University of Bergamo, Bergamo, Italy and McMaster University, Hamilton, Canada