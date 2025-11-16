{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkAfter getExe;
  fortune = pkgs.fortune.override {withOffensive = true;};
in {
  home-manager.sharedModules = [
    # {
    #   xdg.configFile."hammerspoon/init.lua".text =
    #     mkAfter
    #     /*
    #     lua
    #     */
    #     ''
    #       local statusBar = hs.menubar.new()
    #       local fullQuote = ""
    #       local popup = nil

    #       local function getFortune()
    #           local handle, err = io.popen("${getExe fortune} 2>/dev/null")
    #           if not handle then
    #               return "Error getting quote"
    #           end

    #           local result = handle:read("*a")
    #           handle:close()

    #           if result == "" then
    #               return "No quote available"
    #           end

    #           return result
    #       end

    #       local function showPopup()
    #           if popup then
    #               popup:delete()
    #               popup = nil
    #               return
    #           end

    #           local frame = statusBar:frame()
    #           if not frame then
    #               hs.alert.show("Error: Cannot get status bar position")
    #               return
    #           end

    #           local count = 0
    #           for _ in fullQuote:gmatch("\n") do
    #               count = count + 1
    #           end

    #           popup = hs.canvas.new({
    #               x = frame.x,
    #               y = frame.y + frame.h,
    #               w = 300,
    #               h = count * 30
    #           })


    #           popup:appendElements(
    #               {
    #                   type = "rectangle",
    #                   action = "fill",
    #                   fillColor = { red = 0.1, green = 0.1, blue = 0.1, alpha = 0.9 },
    #                   roundedRectRadii = { xRadius = 5, yRadius = 5 }
    #               },
    #               {
    #                   type = "text",
    #                   text = fullQuote,
    #                   textColor = { white = 1, alpha = 1 },
    #                   textSize = 12,
    #                   textAlignment = "left",
    #                   frame = { x = 10, y = (2 * count), w = 280, h = 150 }
    #               }
    #           )

    #           popup:mouseCallback(function(canvas, event, id, x, y)
    #               if event == "mouseUp" then
    #                   popup:delete()
    #                   popup = nil
    #               end
    #           end)

    #           popup:show()
    #       end

    #       local function updateQuote()
    #           fullQuote = getFortune()
    #           local shortQuote = fullQuote:gsub("\n+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    #           if #shortQuote > 50 then
    #               shortQuote = shortQuote:sub(1, 47) .. "..."
    #           end
    #           statusBar:setTitle(shortQuote)
    #           hs.notify.new({title="Fortune", informativeText=shortQuote}):send()
    #       end

    #       if statusBar then
    #           updateQuote()
    #           hs.timer.doEvery(1200, updateQuote)
    #           statusBar:setClickCallback(showPopup)
    #       else
    #           hs.alert.show("Error: Failed to create status bar")
    #       end

    #       hs.eventtap.new({hs.eventtap.event.types.leftMouseDown}, function(event)
    #           if popup and not statusBar:isInMenuBar() then
    #               popup:delete()
    #               popup = nil
    #           end
    #           return false
    #       end):start()

    #     '';
    # }
  ];
}
