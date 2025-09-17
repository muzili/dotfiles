#!/bin/bash

# Neovim 启动性能测试脚本

echo "=== Neovim 启动性能测试 ==="
echo "测试时间: $(date)"
echo

# 测试启动时间（多次平均）
echo "正在进行启动时间测试（10次平均）..."
total_time=0
for i in {1..10}; do
    start_time=$(date +%s%N)
    nvim --headless +qall 2>/dev/null
    end_time=$(date +%s%N)
    duration=$((($end_time - $start_time) / 1000000))  # 转换为毫秒
    total_time=$(($total_time + $duration))
    echo "第 $i 次: ${duration}ms"
done

average_time=$(($total_time / 10))
echo
echo "平均启动时间: ${average_time}ms"

# 生成详细的启动时间报告
echo
echo "生成详细启动时间报告..."
nvim --startuptime /tmp/nvim_startup.log +qall 2>/dev/null

echo "启动时间最慢的 10 个项目:"
tail -n +4 /tmp/nvim_startup.log | sort -k2 -nr | head -10

echo
echo "=== 性能优化建议 ==="
if [ $average_time -gt 200 ]; then
    echo "⚠️  启动时间较慢 (>${average_time}ms)，建议："
    echo "   1. 检查插件数量和配置"
    echo "   2. 使用延迟加载"
    echo "   3. 优化 init.lua"
elif [ $average_time -gt 100 ]; then
    echo "⚡ 启动时间中等 (${average_time}ms)，可以进一步优化"
else
    echo "✅ 启动时间良好 (${average_time}ms)"
fi

echo
echo "详细报告已保存到: /tmp/nvim_startup.log"