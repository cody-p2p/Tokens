#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

// Define a base class for shapes
class Shape {
public:
    virtual void draw() = 0; // Pure virtual function
    virtual ~Shape() {} // Virtual destructor
};

// Define a derived class for circles
class Circle : public Shape {
private:
    double radius;
public:
    Circle(double r) : radius(r) {}
    void draw() override {
        cout << "Drawing a circle with radius " << radius << endl;
    }
};

// Define a derived class for rectangles
class Rectangle : public Shape {
private:
    double width, height;
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    void draw() override {
        cout << "Drawing a rectangle with width " << width << " and height " << height << endl;
    }
};

// Define a derived class for triangles
class Triangle : public Shape {
private:
    double side1, side2, side3;
public:
    Triangle(double s1, double s2, double s3) : side1(s1), side2(s2), side3(s3) {}
    void draw() override {
        cout << "Drawing a triangle with sides " << side1 << ", " << side2 << ", and " << side3 << endl;
    }
};

// Define a class for a shape container
class ShapeContainer {
private:
    vector<Shape*> shapes;
public:
    void addShape(Shape* shape) {
        shapes.push_back(shape);
    }
    void drawAllShapes() {
        for (auto shape : shapes) {
            shape->draw();
        }
    }
};

// Define a function to read shapes from a file
void readShapesFromFile(ShapeContainer& container, const string& filename) {
    ifstream file(filename);
    if (!file) {
        cerr << "Error opening file " << filename << endl;
        return;
    }
    string shapeType;
    while (file >> shapeType) {
        double param1, param2, param3;
        file >> param1 >> param2 >> param3;
        Shape* shape = nullptr;
        if (shapeType == "Circle") {
            shape = new Circle(param1);
        } else if (shapeType == "Rectangle") {
            shape = new Rectangle(param1, param2);
        } else if (shapeType == "Triangle") {
            shape = new Triangle(param1, param2, param3);
        }
        if (shape) {
            container.addShape(shape);
        }
    }
    file.close();
}

int main() {
    ShapeContainer container;
    readShapesFromFile(container, "shapes.txt");
    container.drawAllShapes();
    return 0;
}
