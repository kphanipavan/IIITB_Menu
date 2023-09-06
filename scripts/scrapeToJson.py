import pandas
import numpy
import datetime
import json
import hashlib

ALLDAYS = [
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY",
]

if __name__ == "__main__":
    #    mainData = pandas.read_excel("menu.ods")
    mainData = pandas.read_csv("menu.csv")
    breaksLoc = numpy.where(
        pandas.isna(mainData.drop("Unnamed: 0", axis="columns")).all(1).to_numpy()
        == True
    )[0]
    print(breaksLoc)
    rowNames = mainData["Unnamed: 1"].to_numpy()
    # Item names: x[x["Unnamed: 1"]=="BREAKFAST 1"]["MONDAY"].item()
    # print(breaksLoc)
    finalData = {"menu": {}, "dates": {}, "items": {}}
    for sesNum, ses in enumerate(["bf", "ln", "sk", "dn"]):
        finalData["items"][ses] = mainData["Unnamed: 1"].to_list()[
            breaksLoc[sesNum] + 1 : breaksLoc[sesNum + 1]
        ]
    for dayNumber, eachDay in enumerate(ALLDAYS):
        print(eachDay)
        for aDate in mainData[eachDay][: breaksLoc[0]]:
            # print(type(aDate))
            # aDate = str(aDate.to_pydatetime().date().strftime("%d-%m-%Y"))
            aDate = str(
                datetime.datetime.strptime(aDate, "%Y-%m-%d %H:%M:%S")
                .date()
                .strftime("%d-%m-%Y")
            )
            finalData["dates"][aDate] = str(dayNumber)
        # print(finalData, rowNames, breaksLoc)

        currentMenu = {"bf": {}, "ln": {}, "sk": {}, "dn": {}}
        for i, ses in enumerate(["BREAKFAST", "LUNCH", "SNACKS", "DINNER"]):
            # print(ses)
            for item in rowNames[breaksLoc[i] + 1 : breaksLoc[i + 1]]:
                part = (
                    mainData.loc[breaksLoc[i] + 1 : breaksLoc[i + 1]]
                    .loc[mainData["Unnamed: 1"] == item][eachDay]
                    .item()
                )
                if isinstance(part, float) and (part is numpy.nan):
                    part = "MT"

                # print(f"{item}: {part}")
                if "egg" in part.strip().lower() or "omlet" in part.strip().lower():
                    print(f"EGG Found, {part} at {ses}")
                    eggy = "EGG"
                elif "chicken" in part.strip().lower():
                    eggy = "NON"
                    print(f"Chicken Found, {part} at {ses}")
                else:
                    eggy = "VEG"
                currentMenu[list(currentMenu.keys())[i]][item] = {
                    "name": part.strip().title(),
                    "eggy": eggy,
                }
            # print()
        finalData["menu"][dayNumber] = currentMenu
    # print(finalData)
    with open("data.dart", "w+") as dataWriter:
        allData = "String data = r'" + json.dumps(finalData) + "';"
        dataWriter.write(allData)
    with open("out.json", "w+") as jsonWriter:
        json.dump(finalData, jsonWriter)
    with open("out.txt", "w+") as hashWriter:
        hashWriter.write(hashlib.md5(json.dumps(finalData).encode("utf-8")).hexdigest())
