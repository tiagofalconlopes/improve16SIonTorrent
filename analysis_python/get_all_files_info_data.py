import os
import sys
import csv
import glob
import pandas as pd
import numpy as np

# All paths and files names are set to my computer.
# Change them to adapt to yours.

# Enter the working directory path.
# It is where your working files will be.
print("First you need to indicate the full path of the main directory where your experiments are.")
working_dir = "/home/tf/Documents/PDJ/results_1/results/"
# Function to create/write output file
def my_out_file(my_list, fs_name):
    try:
        with open(fs_name + "_counting_taxa_file.csv", "a+") as of:
            writer_file = csv.writer(of)
            writer_file.writerow(my_list)
    except IOError as err:
        print("IOError error: {0}".format(err))

# In case you missed the final bar (/):
if not working_dir.endswith("/"):
    working_dir += "/"
# Set the first parte of the file name for later usage
tp = int(input("Is the dataset from human(1) or mock(2)? "))
method = int(input("Is the dataset from USEARCH(1) or VSEARCH(2)? "))
first_name = ""
if tp == 1:
    first_name += "human_"
    working_dir += "SRX1044553_human/"
elif tp ==2:
    first_name += "mock_"
    working_dir += "MOCK/"
else:
    sys.exit("Choose a correct number")

if method == 1:
    first_name += "usearch_"
    working_dir += "USEARCH/"
elif method ==2:
    first_name += "vsearch_"
    working_dir += "VSEARCH/"
else:
    sys.exit("Choose a correct number")

print("Choose one of the following directories:")
print("1 - non_uchime")
print("2 - uchime_denovo")
print("3 - uchime_denovo_chimslayer")
print("4 - uchime_denovo_rdp")
print("5 - uchime_denovo_rdp_chimslayer")
print("6 - uchime_ref_chimslayer")
print("7 - uchime_ref_rdp")

opt_choose = int(input("Your option: "))

if opt_choose == 1:
    first_name += "non_uchime"
    working_dir += "non_uchime"
elif opt_choose == 2:
    first_name += "uchime_denovo"
    working_dir += "uchime_denovo/"
elif opt_choose == 3:
    first_name += "uchime_denovo_chimslayer"
    working_dir += "uchime_denovo_chimslayer/"
elif opt_choose == 4:
    first_name += "uchime_denovo_rdp"
    working_dir += "uchime_denovo_rdp/"
elif opt_choose == 5:
    first_name += "uchime_denovo_rdp_chimslayer"
    working_dir += "uchime_denovo_rdp_chimslayer/"
elif opt_choose == 6:
    first_name += "uchime_ref_chimslayer"
    working_dir += "uchime_ref_chimslayer/"
elif opt_choose == 7:
    first_name += "uchime_ref_rdp"
    working_dir += "uchime_ref_rdp/"
else:
    sys.exit("Invalid option!")


# Set the working directory.
# Also, we need to treat any possible exception found.
try:
    os.chdir(working_dir)
except FileNotFoundError as err:
    print("FileNotFound error: {0}".format(err))
except ValueError as err:
    print("ValueError error: {0}".format(err))

# As all files came from the BMP pipeline, they all will end in .spf .
# Thus, lets onpen the SPF files.
# Also, we need to treat any possible exception found.
my_files = glob.glob("*.spf")
try:
    if len(my_files) > 0:
        print("Keep going!")
except:
    print("No SPF files in the specified directory!")

# To open the files, we use a for loop.
# We used pandas read.csv() function to open the data frames.
# Inside the for loop, we need to treat any possible exception found.
for fl in my_files:
    # List index names
    names_of_index = ["Level_1", "Level_2", "Level_3", "Level_4", "Level_5", "Level_6", "Level_7"]
    # List patterns to drop
    names_to_drop = ['unclassified','__unclassified','__uncultured','__unidentified','__uncultured','ambiguous_taxa','__gut metagenome','__family']
    # For each index do open the file using the specified index
    for i in names_of_index:
        try:
            df_info = pd.read_csv(fl, sep="\t", header=0, index_col = i)
            # Convert index to lowercase to make easy the search step
            df_info.index = df_info.index.str.lower()
            # Convert index to list format to retireve each index name and compare later
            index_list = list(df_info.index)
            # Create empty lists to later storage of duplicated and unique index names to drop
            ls = []
            ls2 = []
            for n_index in index_list:
                for nmtd in names_to_drop:
                    if nmtd in n_index:
                        ls.append(n_index)
            ls2 = np.unique(ls)
            # Drop the unecessary rows
            df_info = df_info.drop(ls2)
            # Print the number of identified taxa at each level
            # File name less the common part: fl[27:]
            ls_out = [first_name, fl[27:], i, len(df_info.index)]
            print(ls_out)
            if i == "Level_1":
                my_out_file(ls_out,first_name + "_" + i)
            elif i == "Level_2":
                my_out_file(ls_out,first_name + "_" + i)
            elif i == "Level_3":
                my_out_file(ls_out,first_name + "_" + i)
            elif i == "Level_4":
                my_out_file(ls_out,first_name + "_" + i)
            elif i == "Level_5":
                my_out_file(ls_out,first_name + "_" + i)
            elif i == "Level_6":
                my_out_file(ls_out,first_name + "_" + i)
            else:
                my_out_file(ls_out,first_name + "_" + i)
        except IOError as err:
            print("IO error: {0}".format(err))
        except:
            print("Something occurred!")

# Finishing
print("Process end")
