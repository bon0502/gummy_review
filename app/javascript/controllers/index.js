import { application } from "./application"

// esbuildを使用する場合、コントローラーを明示的にインポートする必要があります
import ImageResizeController from "./image_resize_controller"

// コントローラーを登録
application.register("image-resize", ImageResizeController)
