import Foundation

enum Building{
    case city(intersection: Intersection)
    case settelment(intersection: Intersection)
    case road(path: Path)
}
