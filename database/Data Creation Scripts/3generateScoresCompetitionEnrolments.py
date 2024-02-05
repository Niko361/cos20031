import csv
import random

def main():
#    for i in range(1,65):
#        print("insert into Competitions (competition_name, category_id, championship_id) values ('Glenferrie Archery Tournament', '" + str(i) +"', '1');")
    equipment_id =["R", "C", "B", "L"]

    round_score_id = 0
    range_score_id = 0
    end_score_id = 0

    output_file = open("ArcherDB_2_PopulateScoresCompetitionEnrolments.sql", "w")

    with open('Archers.csv', newline='') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in csvreader: #itterates through every row in the archers CSV
            round_score_id += 1
            
            archer_id = row[0]
            archer_gender = row[3]
            archer_birth_year = row[4]
            
            equipment_num = (random.randrange(4) + 1) # randomly selected; 1 for recurve, 2 for compound, 3 for barebow, 4 for longbow
            equpment_name = equipment_id[equipment_num-1]

            category_id = findCategory(archer_gender, archer_birth_year, equipment_num)
            competition_id = category_id #previously populated competition IDs correspond to category IDs 1:1
            
            round_time_hour = random.randrange(10) + 9 #random hour between 8am and 6pm
            round_time_min = random.randrange(60) #random minute
            round_time_second = random.randrange(60) #random second
            round_time_millisecond = random.randrange(1000) #random millisecond
            round_score_date_time = '2023-04-23 ' + str(round_time_hour) + ":"  + str(round_time_min) + ":"  + str(round_time_second) + "."  + str(round_time_millisecond) #assuming all rounds were shot on the same day during a random time.

            round_def_id = findRoundDefID(category_id)
            round_range_id = (round_def_id - 1) * 4 #calculate the correct starting round_range_id

            output_file.write("insert into CompetitionEnrolments (archer_id, competition_id) values ('" 
                + str(archer_id) + "', '" + str(competition_id) + "');\n")
            
            total_score = 0
            scores=[] #2d array for scores, representing 4 ends with 6 arrows each
            for i in range(1,5):
                ends=[]
                for j in range(1,7):
                    arrows=[]
                    for k in range(1,7):                        
                        score = random.randrange(10) #possible scores are 0 to 10
                        total_score += score
                        arrows.append(score)
                    arrows.sort(reverse=True)
                    ends.append(arrows)
                scores.append(ends)

            #generate the statement that inserts a roundscore into the table
            output_file.write("insert into RoundScores (round_score_id, archer_id, competition_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id) values ('" 
                  + str(round_score_id) + "', '" + archer_id + "', '" + str(competition_id) + "', '" + round_score_date_time + "', '" + equpment_name + "', '" 
                  + str(round_def_id) + "', '" + str(total_score) + "', '" + str(category_id) + "');\n")

            #generate the statements that insert RangeScores and EndScores into the table
            for rangescore in scores:
                end_number = 1
                range_score_id += 1
                round_range_id += 1
                output_file.write("insert into RangeScores (range_score_id, round_score_id, round_range_id) values ('" + str(range_score_id) + "', '" + str(round_score_id) + "', '" + str(round_range_id) + "');\n")
                for endscore in rangescore:
                    end_score_id += 1
                    output_file.write("insert into EndScores (end_id, range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) values ('"
                          + str(end_score_id) + "', '" +  str(range_score_id) + "', '" +  str(end_number) + "', '" +  str(endscore[0]) + "', '"
                          + str(endscore[1]) + "', '" +  str(endscore[2]) + "', '" +  str(endscore[3]) + "', '" +  str(endscore[4]) + "', '"+  str(endscore[5])+ "');\n")
                    end_number += 1

def findRoundDefID(category_id): #returns the correct round_def_id based on a given category_id
    match(category_id):
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 2
        case 4:
            return 3
        case 5:
            return 2
        case 6:
            return 2
        case 7:
            return 3
        case 8:
            return 4
        case 9:
            return 2
        case 10:
            return 2
        case 11:
            return 3
        case 12:
            return 4
        case 13:
            return 3
        case 14:
            return 3
        case 15:
            return 3
        case 16:
            return 4
        case 17:
            return 3
        case 18:
            return 3
        case 19:
            return 3
        case 20:
            return 4
        case 21:
            return 4
        case 22:
            return 4
        case 23:
            return 4
        case 24:
            return 4
        case 25:
            return 3
        case 26:
            return 3
        case 27:
            return 3
        case 28:
            return 4
        case 29:
            return 4
        case 30:
            return 4
        case 31:
            return 4
        case 32:
            return 4
        case 33:
            return 1
        case 34:
            return 1
        case 35:
            return 2
        case 36:
            return 3
        case 37:
            return 2
        case 38:
            return 2
        case 39:
            return 3
        case 40:
            return 4
        case 41:
            return 2
        case 42:
            return 2
        case 43:
            return 3
        case 44:
            return 4
        case 45:
            return 3
        case 46:
            return 3
        case 47:
            return 4
        case 48:
            return 4
        case 49:
            return 4
        case 50:
            return 4
        case 51:
            return 5
        case 52:
            return 5
        case 53:
            return 4
        case 54:
            return 4
        case 55:
            return 5
        case 56:
            return 5
        case 57:
            return 5
        case 58:
            return 5
        case 59:
            return 5
        case 60:
            return 5
        case 61:
            return 5
        case 62:
            return 5
        case 63:
            return 5
        case 64:
            return 5        

def findCategory(gender, yearofbirth, equipment): #matches archer based on yob, gender, and equipment to match category_id generated by generateCategories.py
    return (findDivision(gender, yearofbirth)-1)*4 + equipment


def findDivision(gender, yearofbirth):
    age = 2023 - int(yearofbirth)
    if(age < 14):
        agegroup = "u14"
    elif (age < 16):
        agegroup = "u16"
    elif (age < 18):
        agegroup = "u18"
    elif (age < 21):
        agegroup = "u21"
    elif (age > 70):
        agegroup = "o70"
    elif (age > 60):
        agegroup = "o60"
    elif (age > 50):
        agegroup = "o50"
    else:
        agegroup = "open"

    match agegroup:
        case "open":
            match gender:
                case "M":
                    return 1
                case "F":
                    return 2
        case "o50":
            match gender:
                case "M":
                    return 3
                case "F":
                    return 4
        case "o60":
            match gender:
                case "M":
                    return 5
                case "F":
                    return 6
        case "o70":
            match gender:
                case "M":
                    return 7
                case "F":
                    return 8
        case "u21":
            match gender:
                case "M":
                    return 9
                case "F":
                    return 10
        case "u18":
            match gender:
                case "M":
                    return 11
                case "F":
                    return 12
        case "u16":
            match gender:
                case "M":
                    return 13
                case "F":
                    return 14
        case "u14":
            match gender:
                case "M":
                    return 15
                case "F":
                    return 16
    
if __name__ == "__main__":
    main()