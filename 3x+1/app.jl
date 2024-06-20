using Plots, GR, Printf

struct Point
    x::Int32
    y::Int32
end

function getStartNumber()
    print("Type number to start with: ")
    input = split(readline(), " ")
    local startNumber = 0
    try
        startNumber = parse(Int32, input[size(input, 1)])
        return startNumber
    catch e
        println("Please enter a valid number.")
        getStartNumber()
    end
end

function getShouldNumbersShow()
    print("Include the y-values for each point (y / n): ")
    input = split(readline(), " ")
    local response = lowercase(input[size(input, 1)])
    if response == "y" || response == "n"
        return response
    else
        println("Please choose one of the options")
        getShouldNumbersShow()
    end
end

function even(x)
    return x / 2
end

function odd(x)
    return 3 * x + 1
end

function performCalc(START_NUMBER)
    local steps = 1
    local points = []
    local yCoords = []
    push!(points, Point(steps, START_NUMBER))

    while true
        steps += 1
        last_point = points[size(points, 1)]
        y = last_point.y % 2 == 0 ? even(last_point.y) : odd(last_point.y)
        point = Point(steps, y)
        push!(points, point)
        if y == 1
            break
        end
    end

    # save all the y-coords to a different array to use in the scatter function later
    foreach(p -> push!(yCoords, p.y), points)
    return points, yCoords, steps
end

function drawGraph()
    START_NUMBER = getStartNumber()
    points, yCoords, steps = performCalc(START_NUMBER)

    gr()
    p = Plots.plot(scatter!(1:steps, yCoords, mc=:green, ms=5, ma=1))
    # draw the lines, drawn using [x1, x2], [y1, y2]
    for i = 1:size(points, 1)-1
        plot!([points[i].x, points[i+1].x], [points[i].y, points[i+1].y], linecolor=:green, linewidth=2)
    end
    # add the numbers showing the y-level of the point
    if lowercase(getShouldNumbersShow()) == "y"
        foreach(point -> annotate!(point.x, point.y, Plots.text("$(point.y)", :black, :right, :10)), points)
    end
    plot!(legend=:false)
    title!("3x+1 pattern, starting with $START_NUMBER, took $(size(points, 1)) steps")
    xlabel!("x")
    ylabel!("y")
    display(p)

    println("Press any key to continue...")
    readline()
    Plots.pdf("graph")
end

drawGraph()