public class XiEn {
	public static void main(String[] args) {
		int num = 9;
		int size = 38;
		for(int i = 1 ; i <= 5; i++){
		    System.out.print("[" + ((i-1) * num) + ",");
		    System.out.print((i*num > size) ? size - 1 : i*num - 1 + "]");
		}
	}
}
