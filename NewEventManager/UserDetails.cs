using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NewEventManager
{
    public class UserDetails
    {
        private int _id;
        private string username;
        private string password;
        private string title;
        private string fname;
        private string lname;
        private string contactname;
        private string eventcode;
        private string usertype;
        public UserDetails()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        public string UserType
        {
            get { return usertype; }
            set { usertype = value; }
        }
        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public string FirstName
        {
            get { return fname; }
            set { fname = value; }
        }
        public string LastName
        {
            get { return lname; }
            set { lname = value; }
        }
        public string ContactName
        {
            get { return contactname; }
            set { contactname = value; }
        }
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public string Username
        {
            get { return username; }
            set { username = value; }
        }
        public string Password
        {
            get { return password; }
            set { password = value; }
        }
        public string EventCode
        {
            get { return eventcode; }
            set { eventcode = value; }
        }
    }
}
