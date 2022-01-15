# xml_grep
# Autogenerated from man page /usr/share/man/man1/xml_grep.1p.gz
complete -c xml_grep -l help -d 'brief help message'
complete -c xml_grep -l man -d 'full documentation'
complete -c xml_grep -l Version -d 'display the tool version'
complete -c xml_grep -l root -d 'look for and return xml chunks matching <cond> '
complete -c xml_grep -l cond -d 'return the chunks (or file names) only if they contain elements matching <con…'
complete -c xml_grep -l files -d 'return only file names (do not generate an \\s-1XML\\s0 output) '
complete -c xml_grep -l count -d 'return only the number of matches in each file '
complete -c xml_grep -l strict -d 'without this option parsing errors are reported to \\s-1STDOUT\\s0 and the file…'
complete -c xml_grep -l date -d 'when on (by default) the wrapping element get a \\f(CW\\*(C`date\\*(C\' attribute…'
complete -c xml_grep -l encoding -d 'encoding of the xml output (utf-8 by default)'
complete -c xml_grep -l nb_results -d 'output only <nb> results'
complete -c xml_grep -l by_file -d 'output only <nb> results by file'
complete -c xml_grep -l wrap -d 'wrap the xml result in the provided tag (defaults to \'xml_grep\') '
complete -c xml_grep -l nowrap -d 'same as using \\f(CW\\*(C`--wrap \\*(Aq\\*(Aq\\*(C\': the xml result is not wrapped'
complete -c xml_grep -l descr -d 'attributes of the wrap tag (defaults to \\f(CW\\*(C`version="<VERSION>" date="<…'
complete -c xml_grep -l group_by_file -d 'wrap results for each files into a separate element'
complete -c xml_grep -l exclude -d 'same as using \\f(CW\\*(C`-v\\*(C\' in grep: the elements that match the conditio…'
complete -c xml_grep -l pretty_print -d 'pretty print the output using XML::Twig styles (\'\\f(CW\\*(C`indented\\*(C\'\', \'\\…'
complete -c xml_grep -l text_only -d 'Displays the text of the results, one by line'
complete -c xml_grep -l html -d 'Allow \\s-1HTML\\s0 input, files are converted using HTML::TreeBuilder'

