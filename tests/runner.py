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
passed = 0
failed = 0
for fn in os.listdir(input_dir):
   if fn.endswith('.cm'):
      print('Running ' + fn)
      file_name = "input/" + fn
      assembly_name = file_name.replace('.cm', '.s')
      executable_name = file_name.replace('.cm', '')
      output_name = file_name.replace('.cm', '.output')

      print 'Compiling cminus file into assembly...'
      call(["./cmc", file_name])

      try:
        print 'Compiling assembly file into executable...'
        call(["gcc", "-o", executable_name, assembly_name])
      except:
        print "gcc call failed"

      try:
        print 'Executing executable to output...'
        print executable_name
        print output_name
        f = open(output_name, "w")
        call(["./" + executable_name], stdout=f)
      except:
        print "Execution of output failed"
      # shutil.copyfile('input/' + fn.replace('.cm', '.s'), 'tests/' + fn.replace('.cm', '.s'))

      same = False
      try:
        same = filecmp.cmp(output_name, 'tests/' + fn.replace('.cm', '.s'))
      except:
        print "Comparision failed. No such file."

      if(same):
        passed += 1
        print 'Test passed for ' + fn + '!'
      else:
        failed += 1
        failure_occurred = True
        print 'FAILURE for ' + fn + '. This could be due to many reasons, including invalid gold file.'

print 'Passed: ' + str(passed)
print 'Failed: ' + str(failed)
if failure_occurred:
  print 'At least one of the tests FAILED'
else:
  print 'All tests PASSED'