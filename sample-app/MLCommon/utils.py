import ast
from pydantic import BaseModel
from typing import Dict,List
def read_txt_files(file_path):
    data = open(file_path, "r", encoding="utf8", errors='replace').read()
    return data

def get_dict_from_txt(file_path):
    file = open(file_path, "r")
    contents = file.read()
    dictionary = ast.literal_eval(contents)
    file.close()
    return dictionary



class request_body(BaseModel):
    '''
    client_id: Clients' unique user Id assigned during registration.
    texts:[{id: text id, by which text could be unquely identified in the database.
    text: Text to be analysed}].
    texts list could be of any size.
    '''
    client_id:str
    texts:List[Dict]
    workflow_id:str
    class config:
    	schema_extra = {
    		"example":{
    			"client_id": "c1012",
  				"texts": [{"text":"What is this!!","user":{"userName":"Killian"},"textID":"c102"}],
  				"workflow_id": "c0102"
    		}
    	}

class request_body_wordcloud(BaseModel):
    texts:Dict

class Task(BaseModel):
    task_id: str
    status: str
class Result(BaseModel):
    task_id: str
    status: str

#{"id":"262b6bc9-22b1-40e7-bd2a-62e0f98f199a","text":":wave: Hello, team!","timeSent":"1629344709.000300","userID":"U02B6BQU8NT","userName":"anjani"}
