-- Aguarda o jogo carregar completamente
repeat task.wait() until game:IsLoaded()

-- Define os principais objetos do jogador
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Aguarda o personagem carregar com a parte principal do corpo
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Teleporta para o portal Nightmare (ajuste a posição se o jogo mudar)
local nightmarePosition = Vector3.new(417.38, 162, -6)
character:MoveTo(nightmarePosition)
print("🟪 Teleportado para o portal Nightmare")

-- Aguarda ser colocado dentro da partida
task.wait(10)

-- Procura o botão "Start" e tenta clicar automaticamente
local gui = player:WaitForChild("PlayerGui")
local success = false

for i = 1, 60 do -- tenta por até 30 segundos (0.5 * 60)
    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Text and obj.Text:lower() == "start" then
            if obj.Visible and obj.Active and obj.AutoButtonColor ~= false then
                print("🟢 Botão Start encontrado e ativo, clicando...")

                pcall(function() obj:Activate() end)
                pcall(function() obj.MouseButton1Click:Fire() end)
                pcall(function() obj.MouseButton1Down:Fire() end)

                success = true
                break
            end
        end
    end
    if success then break end
    task.wait(0.25) -- reduzido para tentar com mais frequência
end

if success then
    print("🎮 Partida iniciada com sucesso!")
else
    warn("❌ Não foi possível encontrar o botão Start.")
end
