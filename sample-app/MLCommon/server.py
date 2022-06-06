import os
import sys
import inspect

currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir) 

from TextualAnalysis.GetTextAnalysis.GetTextAnalysis import GetTextualAnalysis
from PIIDetection.PII_Detection import *
from DBManager.dbManager import DBManager
from InsultDetection.Deeppalov_InsultDetection import InsultDetection
from ProfanityDetection.ProfanityDetection import CheckProfanity
from ScriptDetection.ScriptDetection import ScriptDetection
from TextualAbuseDetection.TextualAbuseDetection import textual_abuseDetection


class server(object):
    def __init__(self):
        self.textual_analysis = GetTextualAnalysis()
        self.piiDetection = PIIDetection()
        self.db=DBManager("texts")
        self.insultDetector = InsultDetection()
        self.profanity_detection=CheckProfanity()
        self.script_detection=ScriptDetection()
        self.textual_abuse=textual_abuseDetection()
        

