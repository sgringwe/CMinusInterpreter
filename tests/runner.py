import os
import string
from subprocess import call
import shutil
import filecmp

# This is the runner file absolute path
full_path = os.path.realpath(__file__)

test_dir = os.path.dirname(full_path)
input_dir = test_dir.replace('/tests', '/input')

print('Test dir: ' + test_dir)
print('Input dir: ' + input_dir)

failure_occurred = False

# Go through each .cmc file in input and run it
# Then, compare the output to that of the gold file.
# If it matches, success. Otherwise we have an error.
for fn in os.listdir(input_dir):
   if fn.endswith('.cm'):
      print('Running ' + fn)
      file_name = "input/" + fn
      assembly_name = file_name.replace('.cm', '.s')
      executable_name = file_name.replace('.cm', '')
      output_name = file_name.replace('.cm', '.output')
      call(["./cmc", file_name])
      call(["gcc", "-o", executable_name, assembly_name])
      call(["./" + executable_name, ">", output_name])
      # shutil.copyfile('input/' + fn.replace('.cm', '.s'), 'tests/' + fn.replace('.cm', '.s'))

      same = filecmp.cmp(output_name, 'tests/' + fn.replace('.cm', '.s'))

      if(same):
        print 'Test passed for ' + fn + '!'
      else:
        failure_occurred = True
        print 'FAILURE for ' + fn + '. This could be due to many reasons, including invalid gold file.'
      
if failure_occurred:
  print 'At least one of the tests FAILED'
else:
  print 'All tests PASSED'