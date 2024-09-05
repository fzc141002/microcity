lines = GetControl("link.shp")
visited = {}

function GetNextAdj(v)				--获得下一个邻接点
	for i = 1, GetRecCount(lines) do
		local o = GetValue(lines, "O", i)
		local d = GetValue(lines, "D", i)
		if o==v and not visited[d] then
			return d
		elseif d==v and not visited[o] then
			return o
		end
	end
end

function DepthFirstSearch(v) 		--从v出发深度优先遍历图g
	Print(v) 
	visited[v] = true
	local w = GetNextAdj(v)			--w为v的邻接点 
  	while w do							--当邻接点未访问 
		DepthFirstSearch(w)			--递归调用
     	w = GetNextAdj(v)			--找下一邻接点 
  	end
end

DepthFirstSearch(1)
