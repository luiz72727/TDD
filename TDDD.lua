-- Aguarda o jogo carregar completamente
repeat task.wait() until game:IsLoaded()

-- Referências principais
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Teleporta pro portal Nightmare
local nightmarePosition = Vector3.new(417.38, 162, -6)
character:MoveTo(nightmarePosition)
print("🟪 Teleportado para o portal Nightmare")

-- Aguarda um pouco pra entrar na sala
task.wait(2)

-- Começa a tentar clicar no botão Start
local gui = player:WaitForChild("PlayerGui")
local success = false

for i = 1, 200 do -- tenta por até 20 segundos
    for _, obj in pairs(gui:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Text and obj.Text:lower() == "start" then
            if obj.Visible and obj.AbsoluteSize.Magnitude > 0 then
                local pos = obj.AbsolutePosition + (obj.AbsoluteSize / 2)

                -- Clica no centro do botão
                VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
                VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)

                print("🟢 Tentando clicar no botão Start...")
                success = true
            end
        end
    end
    if success then
        -- continua tentando clicar por alguns segundos, mesmo depois de achar o botão
        task.wait(0.1)
    else
        task.wait(0.05)
    end
end

if success then
    print("🎮 Tentativas de clique finalizadas. Se o botão respondeu, a partida começou!")
else
    warn("❌ Não foi possível clicar no botão Start.")
end
