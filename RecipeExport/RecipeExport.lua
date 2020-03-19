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



  --DEFAULT_CHAT_FRAME:AddMessage(outputString);

  local recipesParam = "!recipeadd ";
  
  
  DEFAULT_CHAT_FRAME:AddMessage(table.getn(recipes));
  --iterate over all recipes
  for index, recipe in pairs(recipes) do
    local currentParam = "\n" .. recipes[index];
    --check if the current recipe would make the param string longer than 2k chars, if not, we can concat it
    if (string.len(recipesParam) + string.len(currentParam) < 2000) then
      recipesParam = recipesParam .. currentParam;
    else
    --if it does make the param string longer than 2k chars, we print out the string and reset it to start a new recipeAdd command
      DEFAULT_CHAT_FRAME:AddMessage(recipesParam);
      recipesParam = "!recipeadd ";
    end
  end

  DEFAULT_CHAT_FRAME:AddMessage(recipesParam);
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