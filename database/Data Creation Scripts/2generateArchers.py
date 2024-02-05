import csv
import random

def main():
    output_file = open("ArcherDB_3_PopulateAccounts.sql", "w")

    with open('Archers.csv', newline='') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in csvreader: #itterates through every row in the archers CSV
            #output_file.write("insert into Archers (archer_id, archer_firstname, archer_lastname, archer_gender, archer_birthyear) values ('" 
            #      + row[0] + "', '" + row[1] + "', '" + row[2] + "', '" + row[3] + "', '" + row[4] + "');\n")
            output_file.write("insert into UserAccounts(user_id, user_password, is_recorder) values ('" 
                  + row[0] + "', 'password', '0');\n")
    
if __name__ == "__main__":
    main()