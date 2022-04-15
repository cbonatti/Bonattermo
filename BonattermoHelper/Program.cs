using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace BonattermoHelper
{
    class Program
    {
        private static List<string> words;

        static async Task Main(string[] args)
        {
            words = await FiveLengthWords("https://raw.githubusercontent.com/fserb/pt-br/master/data");
            await File.WriteAllLinesAsync("words.txt", words);
            Console.WriteLine("Processo Finalizado!");
        }

        static async Task<List<string>> FiveLengthWords(string url)
        {
            var client = new HttpClient();
            var result = await client.GetAsync(url);
            var content = await result.Content.ReadAsStringAsync();
            return content
                        .Split('\n')
                        .Where(x => 
                            x.IndexOf(',') == 5 
                            && Convert.ToInt64(x.Substring(6, x.IndexOf(',', 6) - 6)) > 100000)
                        .Select(x => x.Substring(0, 5))
                        .ToList();
        }
    }
}
