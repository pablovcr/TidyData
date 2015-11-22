
*Variables

This file describes the data processing done through the provided script 'run_analysis.R'. You should be able to find 
the script in this repo. The script will execute some data merging and transformations in order to process an existing
dataset which was provided by the Course Project instructors, and is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Since there is a well defined Code book there for most of the variables, I will focus on describing the results that 
we were asked to produce during the assignment.

From all the 561 variables described in the file I have filter most of them, and just got a total of 66 variables,
which describe means and standard deviations. Additionally, 2 new variables were added for subjects who participated
in the experiment, and another variable for the activity.

Variable 1
ActivityLabel: describes the activity that the corresponding subject was being measured for.

Variable 2
SubjectId: describes the 'id' of the subjects participating in the experiment.

Variables 3 to 68
These variables are the mean values of the variables described in the original code book.

Finally, all data was grouped by activity and subject and summarized to get the mean of the other 66 variables as it
was mentioned already.

*The Code

The source code is well documented and you can refer to its comments for help.
