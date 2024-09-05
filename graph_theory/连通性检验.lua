lines=Open("waterways.shp")
nodes=Open("nodes.shp")
marked,stpdis,preid={},{},{}
a,b=1,7
for i=1,GetRecCount(nodes) do
    if i==a then
        marked[i],stpdis[i],preid[i]= true,0,"无"
    else
        marked[i],stpdis[i],preid[i]=false,10000000,-1		
    end
end
crtid,endid = a	,b				--设置当前节点
while crtid ~= endid	do			--搜索直到终点
    for i = 1, GetRecCount(lines) do 			--搜索所有链接
        line=GetShape(lines,i)
        linko=GetValue(lines,"O",i)
        if linko == crtid then		--如果与当前节点邻接
            tmpid = GetValue(lines,"D",i)				--并且另一端点的最短距离较大
            linkdis=GetValue(lines,"W",i)
            if stpdis[crtid] + linkdis < stpdis[tmpid] then
                stpdis[tmpid] = stpdis[crtid] + linkdis
                preid[tmpid] = crtid		--修改另一端点的最短距离和前溯节点
                SetValue(lines,0,"ID",i)
                if i>11 then
                    SetValue(lines,0,"ID",i-11)
                end
            Update(lines)
        end
    end
end
crtid = endid					--设置下一个当前节点
for nodeid = 1, GetRecCount(nodes)	 do 		--搜索所有节点
    if stpdis[endid]~=10000000 then
        break
    end
    if not marked[nodeid]		--找到未标记的有最小距离的节点
       and stpdis[nodeid] < stpdis[crtid] then
       crtid = nodeid				--重新设置当前节点
    end 
end
  marked[crtid] = true			--标记新的当前节点
--      print("当前在最短路上的",crtid,"位置")
end

if stpdis[b]~=10000000 then
    print("从",a,"到",b,"连通")
    print("从",a,"到",b,"的最短距离为：",stpdis[b])
else
    print("从",a,"到",b,"不连通")
end

