from genderclassifier import gender_classifier

model = gender_classifier()

x = input()

print(model.predict_gender(x))
