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
    #! TODO: Find a better XLSX import process. XLS IS ASS
    #    mainData = pandas.read_excel("menu.ods")
    mainData = pandas.read_csv("menu.csv", skiprows=1)
    mainData = mainData.replace("\xa0", numpy.nan)
    breaksLoc = numpy.where(pandas.isna(mainData["\xa0"]).to_numpy() == False)[0]
    breaksLoc = numpy.append(breaksLoc, [len(mainData)])
    print(breaksLoc)
    rowNames = mainData["\xa0.1"].to_numpy()
    finalData = {"menu": {}, "dates": {}, "items": {}}
    for sesNum, ses in enumerate(["bf", "ln", "sk", "dn"]):
        finalData["items"][ses] = mainData["\xa0.1"].to_list()[
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
        if eachDay in ["SUNDAY", "SATURDAY"]:
            currentMenu["bfTimings"] = {"start": "07:45AM", "end": "10:00AM"}
            currentMenu["lnTimings"] = {"start": "12:45PM", "end": "02:30PM"}
            currentMenu["skTimings"] = {"start": "04:30PM", "end": "05:45PM"}
            currentMenu["dnTimings"] = {"start": "07:30PM", "end": "09:30PM"}
        else:
            currentMenu["bfTimings"] = {"start": "07:30AM", "end": "09:45AM"}
            currentMenu["lnTimings"] = {"start": "12:30PM", "end": "02:15PM"}
            currentMenu["skTimings"] = {"start": "04:30PM", "end": "05:45PM"}
            currentMenu["dnTimings"] = {"start": "07:30PM", "end": "09:30PM"}

        for i, ses in enumerate(["BREAKFAST", "LUNCH", "SNACKS", "DINNER"]):
            # print(ses)
            for item in rowNames[breaksLoc[i] + 1 : breaksLoc[i + 1]]:
                part = (
                    mainData.loc[breaksLoc[i] + 1 : breaksLoc[i + 1]]
                    .loc[mainData[" .1"] == item][eachDay]
                    .item()
                )
                if isinstance(part, float) and (part is numpy.nan):
                    part = "MT"
                if part.strip() == "":
                    part = "MT"

                # print(f"{item}: {part}")
                if (
                    "egg" in part.strip().lower()
                    or "omlet" in part.strip().lower()
                    or "omelet" in part.strip().lower()
                ):
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
    with open("out.json", "w+") as jsonWriter:
        json.dump(finalData, jsonWriter)
    with open("out.txt", "w+") as hashWriter:
        hashWriter.write(hashlib.md5(json.dumps(finalData).encode("utf-8")).hexdigest())
