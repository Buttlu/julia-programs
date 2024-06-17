using Plots, GR, PlotlyJS, Printf

struct Point
    x::Int32
    y::Int32
end

println("Type number to start with: ")

global START_NUMBER = parse(Int32, readline())
global steps = 1
global points = []
global yCoords = []

function even(x)
    return x / 2
end

function odd(x)
    return 3 * x + 1
end

function performCalc()
    push!(points, Point(steps, START_NUMBER))
    while true
        global steps += 1
        last_point = points[size(points, 1)]
        y = last_point.y % 2 == 0 ? even(last_point.y) : odd(last_point.y)
        point = Point(steps, y)
        push!(points, point)
        if y == 1
            break
        end
    end
    foreach(p -> push!(yCoords, p.y), points)
end

performCalc()

gr()
p = Plots.plot(scatter!(1:steps, yCoords, mc=:blue, ms=5, ma=1))
for i = 1:size(points, 1)-1
    plot!([points[i].x, points[i+1].x], [points[i].y, points[i+1].y], linecolor=:blue, linewidth=2)
end
plot!(legend=:false)
title!("3x+1 pattern, starting with $(START_NUMBER)")
xlabel!("x")
ylabel!("y")
display(p)

#readline()
Plots.pdf("graph")