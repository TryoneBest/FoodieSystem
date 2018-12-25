export default function Maploader(){
    return new Promise((resolve, reject) => {
        if(window.AMap){
            resolve(window.AMap)
        }else{
            var script = document.createElement('script')
            script.type = 'text/javascript'
            script.async = true
            script.src = 'https://webapi.amap.com/maps?v=1.4.11&key=1c1947a94648a921d5b35088a7eb9751'
            script.onerror = reject
            document.head.appendChild(script)
        }
        window.initAMap = () => {
            resolve(window.AMap)
        }
    })
}