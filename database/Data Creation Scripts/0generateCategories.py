def main():
    agegroups = ['Open','O50','O60','O70','U21','U18','U16','U14']
    gender = ['M', 'F']
    equipment = ['R', 'C', 'B', 'L']
    catid = 1
    for i in agegroups:
        for j in gender:
            for k in equipment:
                print("insert into Categories (category_id, age_group, gender, equipment_id) values ('" + str(catid) + "', '"+ i + "', '" + j + "', '" + k + "');")
                catid += 1

if __name__ == "__main__":
    main()