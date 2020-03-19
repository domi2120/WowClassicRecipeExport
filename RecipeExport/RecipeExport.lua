SLASH_EXR1 ="/exr"
SlashCmdList["EXR"] = function(msg)
  local name, type;

  if (GetNumTradeSkills() < 1) then
    print("you either have no recipes, or need to first open your profession window (the one that lists your recipes)");
    return;
  end

  local first = true;
  local outputString = "";
  local recipes = {};

  
  
  EditBox_Show("test test test");

  for i=1,GetNumTradeSkills() do
    name, type, _, _, _, _ = GetTradeSkillInfo(i);
    if (name and type ~= "header") then
      if (first) then
        --DEFAULT_CHAT_FRAME:AddMessage("!recipeadd " ..name);
      outputString = outputString .. "!recipeadd " .. name;
      recipes[i] = name;
      first = false;
      else
        --DEFAULT_CHAT_FRAME:AddMessage(name);
        outputString = outputString .. "\n" .. name;
        recipes[i] = name;
      end
    end
  end

  --for debuggings sake, generates extra recipes so a second command needs to be created
  --[[
  for i = 1,100 do
    table.insert(recipes, "recipe number: " .. tostring(i));
  end
  ]]--


  local recipesParam = "!recipeadd ";
  
  
  --DEFAULT_CHAT_FRAME:AddMessage(table.getn(recipes));
  --iterate over all recipes
  for index, recipe in pairs(recipes) do
    local currentParam = "\n" .. recipes[index];
    --check if the current recipe would make the param string longer than 2k chars, if not, we can concat it
    if (string.len(recipesParam) + string.len(currentParam) < 2000) then
      recipesParam = recipesParam .. currentParam;
    else
    --if it does make the param string longer than 2k chars, we print out the string and reset it to start a new recipeAdd command
      --DEFAULT_CHAT_FRAME:AddMessage(index);
      EditBox_Show(recipesParam, tostring(index));
      recipesParam = "!recipeadd ";
    end
  end

  --TODO
  --create ui window, possibly multiple text boxes if the export has to be split into multiple discord messages
  --DEFAULT_CHAT_FRAME:AddMessage(recipesParam);
  EditBox_Show(recipesParam, tostring(9934534));
end 

function TableConcat(t1,t2)
  for i=1,#t2 do
      t1[#t1+1] = t2[i]
  end
  return t1
end

function makeString(l)
  if l < 1 then return nil end -- Check for l < 1
  local s = "" -- Start string
  for i = 1, l do
          s = s .. string.char(math.random(32, 126)) -- Generate random number from 32 to 126, turn it into character and add to string
  end
  return s -- Return string
end

function EditBox_Show(text, suffix)
  --if not EditBox then
  
  --DEFAULT_CHAT_FRAME:AddMessage("test");
  DEFAULT_CHAT_FRAME:AddMessage(suffix);
  if not suffix then
    return
  end

    if suffix then 
      editBoxName = 'EditBox_' .. suffix;
      editBoxEditBoxName = 'EditBoxEditBox_' .. suffix;
      editBoxScrollFrameName = 'EditBoxScrollFrame_' .. suffix;
      editBoxResizeButtonName ='EditBoxResizeButton_' ..suffix;

      local f = CreateFrame("Frame", editBoxName, UIParent, "DialogBoxFrame")
      f:SetPoint("CENTER")
      f:SetSize(200, 200)
      
      f:SetBackdrop({
          bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
          edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
          edgeSize = 16,
          insets = { left = 8, right = 6, top = 8, bottom = 8 },
      })
      f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue
      
      -- Movable
      f:SetMovable(true)
      f:SetClampedToScreen(true)
      f:SetScript("OnMouseDown", function(self, button)
          if button == "LeftButton" then
              self:StartMoving()
          end
      end)
      f:SetScript("OnMouseUp", f.StopMovingOrSizing)
      
      -- ScrollFrame
      
      --DEFAULT_CHAT_FRAME:AddMessage("adding scrollframe \"" .. editBoxScrollFrameName .. "\" to " .. editBoxName );
      local sf = CreateFrame("ScrollFrame", editBoxScrollFrameName, _G[editBoxName], "UIPanelScrollFrameTemplate")
      sf:SetPoint("LEFT", 16, 0)
      sf:SetPoint("RIGHT", -32, 0)
      sf:SetPoint("TOP", 0, -16)
      sf:SetPoint("BOTTOM", _G[editBoxName .. 'Button'], "TOP", 0, 0)
      
      -- EditBox
      local eb = CreateFrame("EditBox", editBoxEditBoxName,  _G[editBoxScrollFrameName])
      eb:SetSize(sf:GetSize())
      eb:SetMultiLine(true)
      eb:SetAutoFocus(false) -- dont automatically focus
      eb:SetFontObject("ChatFontNormal")
      eb:SetScript("OnEscapePressed", function() f:Hide() end)
      sf:SetScrollChild(eb)
      
      -- Resizable
      f:SetResizable(true)
      f:SetMinResize(150, 100)
      
      local rb = CreateFrame("Button", editBoxResizeButtonName, EditBox)
      rb:SetPoint("BOTTOMRIGHT", -6, 7)
      rb:SetSize(16, 16)
      
      rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
      rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
      rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
      
      rb:SetScript("OnMouseDown", function(self, button)
          if button == "LeftButton" then
              f:StartSizing("BOTTOMRIGHT")
              self:GetHighlightTexture():Hide() -- more noticeable
          end
      end)
      rb:SetScript("OnMouseUp", function(self, button)
          f:StopMovingOrSizing()
          self:GetHighlightTexture():Show()
          eb:SetWidth(sf:GetWidth())
      end)
      f:Show()
    end
  --end
  
  if text then
    _G[editBoxEditBoxName]:SetText(text)
    t = 1 + 1;
  end
  _G[editBoxName]:Show()
end