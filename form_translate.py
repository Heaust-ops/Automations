import re
project_folder_path = "Add your project folder path" # change 'Add your project folder path' to your project folder destination where your files are
k = input("Enter file name: ")
k = project_folder_path + k
with open(k, "r") as file:
    document = file.read()

    k = input("Enter form tag: ")
    document = document[(document.index(k) + len(k)):document[document.index(k)::].index("</form>")+document.index(k)]
    pattern = re.compile(r"""\n.*(<input|<select|<textarea).*name *= *["']([^"']*).*>""")
    string = [i[1] for i in pattern.findall(document)]
    string = list(set(string))
    for j, i in enumerate(string):
        if i.endswith("[]"):
            string[j] = "\".implode(',', $_POST['" + i[::-1][2::][::-1] + "']).\""
        else:
            string[j] = "\".$_POST['" + i + "'].\""
k = input("Enter ajax file name: ")
k = project_folder_path + k
with open(k, "a+") as file:
    fields = [input("What is " + i + " in db : ") for i in string]
    string = [" `" + f + "` = '" + s + "' " for f,s in zip(fields, string)]
    writ = ", ".join(string)
    writ = "<?php\ninclude \"config.php\";\nsession_start();\nif(isset($_POST['form_id']))\n" + "{\n" + "$pdo->prepare(\"UPDATE `" + input("Enter the name of the table you wanna update: ") + "` SET "+ writ +" WHERE id = '' ;\")->execute();" + "\n}\n?>"
    file.write(writ)
