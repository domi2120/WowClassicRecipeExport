SLASH_EXR1 ="/exr"
SlashCmdList["EXR"] = function(msg)
  local name, type;

  if (GetNumTradeSkills() < 1) then
    print("you either have no recipes, or need to first open your profession window (the one that lists your recipes)");
  end

  local first = true;

  for i=1,GetNumTradeSkills() do
    name, type, _, _, _, _ = GetTradeSkillInfo(i);
    if (name and type ~= "header") then
      if (first) then
      DEFAULT_CHAT_FRAME:AddMessage("!recipeadd " ..name);
      first = false;
      else
        DEFAULT_CHAT_FRAME:AddMessage(name);
      end
    end
  end
end 