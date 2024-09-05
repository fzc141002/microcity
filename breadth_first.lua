Links = GetControl("waterways.shp")
marked = {}


function GetNextAdj(m)      --获得下一个邻接点
    for i = 1, GetRecCount(Links) do
        local o = GetValue(Links, "O", i)
        local d = GetValue(Links, "D", i)
        if o== m and not marked[d] then        --有后续点
            SetValue(Links,2,"ID",i)
            Update(Links)
            return d   
        elseif d==m and not marked[o] then
            return o
            elseif i==GetRecCount(Links) and marked[d] then 
            return nil
        end
   end
end

function BreadthFirstSearch(v)
    local s=""
    local tovisit = {v}      --设置待访问列表
    local cur = 1        --设置当前访问指针
    while tovisit[cur] do
        local m=tovisit[cur]                    --保存当前访问节点
        s=s.."->"..m           --字符串整行输出
        print(s)              --访问并打印
        w = GetNextAdj(m)      --获得邻接点
        while w do        --如果邻接点有效
            marked[w]=true      --标记防止重复
            table.insert(tovisit, w)   --插入到带访问列表
            w = GetNextAdj(m)     --获得第二个邻接点，如果不存在，则跳出whlie循环
        end
        cur = cur + 1       --设置访问指针
    end
    if string.len(s)==3 or string.len(s)==4 then
        print(s,"为末尾节点")
    end
end

marked[1] = true
BreadthFirstSearch(1)
