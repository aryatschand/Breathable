"""
This is the people module and supports all the ReST actions for the
PEOPLE collection
"""

# System modules
from datetime import datetime

# 3rd party modules
from flask import make_response, abort


def get_timestamp():
    return datetime.now().strftime(("%Y-%m-%d %H:%M:%S"))

x = {
        "fname": "Doug",
        "lname": "Farrarstarstararstnetaeintieoarntiosearnteioarsnstarstell",
        "timestamp": get_timestamp(),
    }
# Data to serve with our API
PEOPLE = {}


def read_all():
    """
    This function responds to a request for /api/people
    with the complete lists of people

    :return:        json string of list of people
    """
    # Create the list of people from our data
    return [PEOPLE[key] for key in sorted(PEOPLE.keys())]




def data(person):
    """
    This function creates a new person in the people structure
    based on the passed in person data

    :param person:  person to create in people structure
    :return:        201 on success, 406 on person exists
    """
    

    # Does the person exist already?

    return make_response(
        jsonify(person), 200
    )

    # Otherwise, they exist, that's an error





