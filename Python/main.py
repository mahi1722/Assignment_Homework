tagging_policy = {
    "mandatory_tags": {
        "EC2": {
            "BackupType": ["OrgStandard", "OrgStandardRDS", "LocalOnly", "None", "MigratedLegacy"],
            "carlyle:os-type": ["linux", "windows"],
            "Name": [],
            "carlyle:owner": [],
            "carlyle:primary-poc": [],
            "carlyle:environment": ["dev", "qa", "uat", "staging", "prodint", "prod", "test"],
            "carlyle:application": []
        }
    }
}

def validate_instance_tags(tags):
    for key, value in tags.items():
        if key in tagging_policy["mandatory_tags"]["EC2"]:  # Check if the tag key exists in the policy
            if value in tagging_policy["mandatory_tags"]["EC2"][key] or not tagging_policy["mandatory_tags"]["EC2"][key]: 
                # If the tag value is valid or the policy doesn't specify values (e.g., empty list)
                print(f"Tag {key} with value {value} exists and is valid.")
            else:
                print(f"Tag {key} with value {value} exists but the value is invalid.")
        else:
            print(f"Tag {key} is not a valid tag in the policy.")

# Example tags for validation
tags = {
    'carlyle:environment': 'de', 
    'carlyle:application': 'keepesr', 
    'BackupType': 'OrgStandard',  
    'tcgcloud:exception-ec2-instance-size': '9', 
    'carlyle:os-type': 'linux', 
    'carlyle:owner': 'asasd', 
    'Names': '', 
    'carlyle:primary-poc': '', 
    'abc': '', 
    'Name': ''
}

validate_instance_tags(tags)
