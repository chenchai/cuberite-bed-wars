function MobSearchForTarget(Monster, SearchDistance, AttackDistance, Damage, Knockback)
  
  local ClosestDistance = 1000
  Monster:GetWorld():ForEachPlayer(function(Player)
  
                                    local VectorSum = Monster:GetPosition() - Player:GetPosition()
                                    -- XZ pythagorean distance
                                    local Distance = VectorSum:Length()
                                    
                                    if ClosestDistance > Distance then 
                                      ClosestDistance = Distance
                                    else
                                      return
                                    end
                                    
                                    if Monster.Team == nil then return end
                                    if Player:GetTeam() == nil then return end
                                    
                                    
                                      -- Comparing team names should be more reliable than comparing the whole team object
                                    if Player:GetTeam().GetName() ~= Monster.TeamName then
                                    
                                      if Distance <= SearchDistance then
                                        Monster:MoveToPosition(Player:GetPosition())
                                        LOG(Monster:GetUniqueID() .. " is tracking " .. Player:GetName() .. " at " .. Distance .. " range!")
                                      end
                                    
                                      if Distance <= AttackDistance then
                                        Player:TakeDamage(dtEntityAttack, Monster, Damage, Knockback)
                                      end
                                      
                                    end
                                  end)
  return
  
end