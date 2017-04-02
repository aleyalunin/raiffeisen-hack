using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;

namespace ChatBotApp
{
    [DataContract]
    public class Message
    {
        [DataMember]
        public String message { get; set; }

        public Message(string message)
        {
            this.message = message;
        }
    }
}