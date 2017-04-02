using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AIMLbot;
using System.Web;
using System.IO;

namespace ChatBotApp
{
    class Acutus
    {
        private Bot bot;
        private User user;

        public Acutus(String path)
        {
            bot = new Bot();
            user = new User("userID", bot);
            Initialize(path);
        }

        public void Initialize(String path)
        {
            bot.PathToConfigFiles = path;
            bot.PathToAIML = path;
            bot.loadSettings();
            AIMLbot.Utils.AIMLLoader loader = new AIMLbot.Utils.AIMLLoader(bot);
            bot.isAcceptingUserInput = false;
            loader.loadAIML();
            bot.isAcceptingUserInput = true;
        }

        public String GetOutput(String input)
        {
            Request r = new Request(input, user, bot);
            Result result = bot.Chat(r);
            return result.Output;
        }

    }
}
