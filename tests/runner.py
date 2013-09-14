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
for fn in os.listdir(input_dir):
   if fn.endswith('.cm'):
      print('Running ' + fn)
      call(["./cmc", "input/" + fn])
      # shutil.copyfile('input/' + fn.replace('.cm', '.s'), 'tests/' + fn.replace('.cm', '.s'))

      same = filecmp.cmp('input/' + fn.replace('.cm', '.s'), 'tests/' + fn.replace('.cm', '.s'))

      if(same):
        print 'Test passed for ' + fn + '!'
      else:
        failure_occurred = True
        print 'FAILURE for ' + fn + '. This could be due to many reasons, including invalid gold file.'
      
if failure_occurred:
  print 'At least one of the tests FAILED'
else:
  print 'All tests PASSED'