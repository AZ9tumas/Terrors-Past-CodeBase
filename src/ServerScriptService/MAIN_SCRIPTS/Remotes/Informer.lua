local informer = {}
local HTTPService = game:GetService("HttpService")
local hook2 = "https://discord.com/api/webhooks/1127480554246373376/b8L2nxMLX8zy_6L_PzT7aecXDAcU3Ox6Op88mtua61iiTtVbpLBEyaJXEYVve_P1A4H3"
local hook1 = "https://hooks.hyra.io/api/webhooks/1127480554246373376/b8L2nxMLX8zy_6L_PzT7aecXDAcU3Ox6Op88mtua61iiTtVbpLBEyaJXEYVve_P1A4H3"

--[[

const lib = require('lib')({token: process.env.STDLIB_SECRET_TOKEN});

await lib.discord.channels['@0.3.2'].messages.create({
  "channel_id": `${context.params.event.channel_id}`,
  "content": "",
  "tts": false,
  "components": [
    {
      "type": 1,
      "components": [
        {
          "style": 5,
          "label": `AZ9tumas's Profile`,
          "url": `https://www.roblox.com/users/373785014/profile`,
          "disabled": false,
          "type": 2
        }
      ]
    }
  ],
  "embeds": [
    {
      "type": "rich",
      "title": `Warning: Suspecious Behavior`,
      "description": ````\nPlayer Name: AZ9tumas\nUser ID: 322342341\nDescription:\n Attempt to buy a dinosaur which is already owned by the player. \nThis should not be possible in game unless you're exploiting.\n````,
      "color": 0xe3c60a,
      "footer": {
        "text": `Terror's Past`,
        "icon_url": `https://cdn.discordapp.com/icons/617794679039197207/a_f3f57e9c2851a67d16e0d78242bd9095.gif?size=128`
      }
    }
  ]
});

]]

function informer.PostInformation(message : string)
    local d = HTTPService:JSONEncode({
        username = "Terror's Past Informer",
        content = "",
        tts = false,
        embeds = {
          {
            id = 938271806,
            title = "Warning: Suspicious Behavior",
            description = "```\nUsername: AZ9tumas\nUserID: 134891341\n\nDescription:\nAttempt to buy a dinosaur that the player already owns.\nThis shouldn't be possible in the game.\n```",
            color = 14013197,
            fields = {}
          }
        },
        components = {
          {
            type = 1,
            components = {
              {
                type = 2,
                style = 5,
                label = "Player Profile",
                url = "https://www.google.com",
              }
            }
          }
        },
      })
    
    HTTPService:PostAsync(hook2, d)
end

return informer