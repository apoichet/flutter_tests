import csv
import os

from lxml import etree

results = []


def replace_point_by_comma(number):
    return number.replace(".", ",")


def build_results(result_list, test_name, test_time):
    if len(result_list) == 0:
        result_list.append([test_name, replace_point_by_comma(test_time)])
    else:
        already_have = True
        for result_child in result_list:
            if result_child[0] == test_name:
                result_child.append(replace_point_by_comma(test_time))
                already_have = False
                break
        if already_have:
            result_list.append([test_name, replace_point_by_comma(test_time)])


def build_results_from_report_folders(result_list, report_folder, test_report_name):
    report = etree.parse("../test_reports/" + report_folder.title() + "/" + test_report_name)
    for testsuite in report.getroot():
        for child in testsuite.getchildren():
            if child.tag == "testcase":
                build_results(result_list, child.get('name'), child.get('time'))


for test_report_folder in os.listdir("../test_reports"):
    build_results_from_report_folders(results, test_report_folder, "tests-junit.xml")
    build_results_from_report_folders(results, test_report_folder, "tests-integration-junit.xml")

result_report = open("../test_report.csv", 'w', encoding='UTF8', newline='')
writer = csv.writer(result_report)
writer.writerow(["name", "time"])
for result in results:
    writer.writerow(result)

result_report.close()
